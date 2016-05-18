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

    describe "convert invalid csv" do
      csv = "This is a heading\n1,2,3\n"
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
