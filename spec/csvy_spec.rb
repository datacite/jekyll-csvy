require 'spec_helper'

describe Jekyll::Csvy do
  let(:config) {{ 'markdown' => 'Pandoc',
                  'pandoc' => { 'format' => 'html', 'extensions' => [] }}}
  let(:csv) { File.read(File.expand_path("../example.csv", __FILE__)) }
  let(:md) { File.read(File.expand_path("../example.md", __FILE__)) }
  let(:html) { File.read(File.expand_path("../example.html", __FILE__)) }

  describe "class methods" do
    subject { Jekyll::Csvy }

    it "should initialize" do
      parser = subject.new(Jekyll::Configuration::DEFAULTS.merge(config))
      expect(parser.public_methods).to include(:convert)
    end
  end

  describe "instance methods" do
    subject { Jekyll::Csvy.new Jekyll::Configuration::DEFAULTS.merge(config) }

    describe "convert" do
      it "should convert csv" do
        expect(subject.convert(csv)).to eq(html)
      end
    end

    describe "convert csv with multiple lines in a block" do
      csv = "Header,Options\nOne,\"* 1\n* 2\n* 3\"\n"
      html = "<table style=\"width:32%;\">\n<colgroup>\n<col width=\"12%\" />\n<col width=\"19%\" />\n</colgroup>\n<thead>\n<tr class=\"header\">\n<th align=\"left\">Header</th>\n<th align=\"left\">Options</th>\n</tr>\n</thead>\n<tbody>\n<tr class=\"odd\">\n<td align=\"left\"><p>One</p></td>\n<td align=\"left\"><ul>\n<li>1</li>\n<li>2</li>\n<li>3</li>\n</ul></td>\n</tr>\n</tbody>\n</table>\n"
      it "should convert csv" do
        expect(subject.convert(csv)).to eq(html)
      end
    end

    describe "convert invalid csv" do
      csv = "Header\n1,2,3\n"
      it "should raise error" do
        expect { subject.convert(csv) }.to raise_error(Jekyll::Errors::FatalException, /Conversion failed with error/)
      end
    end
  end

  describe "instance methods with different markdown parser" do
    subject { Jekyll::Csvy.new Jekyll::Configuration::DEFAULTS }

    describe "convert" do
      it "should raise error" do
        expect { subject.convert(csv) }.to raise_error(Jekyll::Errors::FatalException, /Pandoc markdown converter required/)
      end
    end
  end
end
