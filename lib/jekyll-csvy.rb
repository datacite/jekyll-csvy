require 'csv'

module Jekyll
  class Csvy < Converter
    safe true
    priority :low

    def initialize(config)
      Jekyll::External.require_with_graceful_fail "jekyll-pandoc"

      # requires the Pandoc markdown converter
      # install jekyll-pandoc gem and set "markdown: Pandoc" in _config.yml
      unless config["markdown"] == "Pandoc"
        raise Jekyll::Errors::FatalException, "Pandoc markdown converter required"
      end

      @config = config
    end

    def matches(ext)
      ext =~ /^\.csvy$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      # convert csv content into markdown table using grid table format
      content = convert_csv(content)

      # convert grid_tables markdown into HTML table using pandoc
      site = Jekyll::Site.new(@config)
      markdown_converter = site.find_converter_instance(Jekyll::Converters::Markdown)
      markdown_converter.convert(content)
    end

    def convert_csv(content)
      rows = ::CSV.parse(content)

      # calculate max height of each row
      max_heights = rows.map { |r| r.max_by { |x| x.lines.count }}.map { |r| r.lines.count }

      # calculate max width of each column
      columns = rows.transpose
      max_widths = columns.map { |c| c.max_by { |x| x.length }}.map { |c| c.length }

      # header
      table = []
      table << separator_row(rows.first, max_widths)

      # rows
      rows.each_with_index do |row,i|
        delimiter = i == 0 ? "=" : "-"

        table += content_rows(row, max_widths, max_heights[i])
        table << separator_row(row, max_widths, delimiter)
      end

      table.join("\n") + "\n"
    rescue => e
      raise Jekyll::Errors::FatalException, "Conversion failed with error: #{e.message}"
    end

    def content_rows(row, max_widths, max_height)
      content_row = []
      0.upto(max_height - 1) do |j|
        content_row << row.each_with_index.reduce("|") do |sum, (x,i)|
          sum + ' ' + x.lines[j].to_s.chomp + ' ' * (max_widths[i] - x.lines[j].to_s.chomp.length) + " |"
        end
      end
      content_row
    end

    def separator_row(row, max_widths, delimiter = "-")
      row.each_with_index.reduce("+") do |sum, (x,i)|
        sum + delimiter * (max_widths[i] + 2) + "+"
      end
    end
  end
end
