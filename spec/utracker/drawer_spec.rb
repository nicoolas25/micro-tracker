RSpec.describe Utracker::Drawer do
  let(:instance) { described_class.new }

  describe '#write_graph' do
    subject { instance.write_graph(filename) }

    let(:filename) { "spec/test_graph.dot" }
    let(:content) { File.read(filename) }
    let(:graph) do
      node1 = Utracker::Drawer::Node.new('node1', [])
      node2 = Utracker::Drawer::Node.new('node2', nil)
      node1.edges << node2
      [node1, node2]
    end

    before { allow(instance).to receive(:build_graph).and_return(graph) }
    after { File.delete(filename) }

    it "writes the expected file" do
      subject
      expect(content).to eq <<-EXPECTED_FILE
digraph message_flow {
  node [style=filled fillcolor=white]
  rankdir=LR
  node1
  node1 -> node2
  node2
}
      EXPECTED_FILE
    end
  end
end
