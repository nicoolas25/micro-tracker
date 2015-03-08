class Utracker::Drawer

  Node = Struct.new(:service, :edges)

  def write_graph(filename)
    File.open(filename, 'w') do |file|
      file.puts "digraph message_flow {"
      file.puts "  node [style=filled fillcolor=white]"
      file.puts "  rankdir=LR"
      write_graph_into(file)
      file.puts "}"
    end
  end

  protected

  def build_graph
    fail 'Please implement me in subclasses.'
  end

  private

  def write_graph_into(file)
    build_graph.each do |node|
      file.puts "  #{node.service}"
      node.edges && node.edges.each do |connected_node|
        file.puts "  #{node.service} -> #{connected_node.service}"
      end
    end
  end

end
