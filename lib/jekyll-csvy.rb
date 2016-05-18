require 'csv'

module Jekyll
  module Converters
    class Csvy
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

        # convert markdown into HTML table
        # uses pandoc with the grid_tables extension
        # site = Jekyll::Site.new(@config)
        # markdown_converter = site.find_converter_instance(Jekyll::Converters::Markdown)
        # markdown_converter.convert(content)
      end

      def convert_csv(content)
        rows = ::CSV.parse(content)

        # calculate max width of each column
        columns = rows.transpose
        max_widths = columns.map { |c| c.max_by { |x| x.length }}.map { |c| c.length }

        # header
        table = []
        table << separator_row(rows.first, max_widths)

        # header row
        table << content_row(rows.first, max_widths)
        table << separator_row(rows.first, max_widths, delimiter = "=")

        # body rows
        rows[1..-1].each do |row|
          table << content_row(row, max_widths)
          table << separator_row(row, max_widths)
        end

        table.join("\n") + "\n"
      rescue => e
        raise Jekyll::Errors::FatalException, "Conversion failed with error: #{e.message}"
      end

      def content_row(row, max_widths)
        row.each_with_index.reduce("|") { |sum, (x,i)| sum + ' ' + x + ' ' * (max_widths[i] - x.length) + " |" }
      end

      def separator_row(row, max_widths, delimiter = "-")
        row.each_with_index.reduce("+") { |sum, (x,i)| sum + delimiter * (max_widths[i] + 2) + "+" }
      end
    end
  end
end
