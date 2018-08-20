class Parser
  def initialize
    @input_format = ''
  end
  def parse(doc)
    @input_format = input_format(doc)
    { doc.root.name.to_sym => xml_node_to_hash(doc.root) }
  end

  def input_format(doc)
    input_format = 'atom' if doc.root.name == 'feed'
    input_format = 'rss' if doc.root.name == 'rss'
    input_format
  end

  def xml_node_to_hash(node)
    # If we are at the root of the document, start the hash
    if node.element?
      result_hash = {}
      if node.attributes != {}
        attributes = {}
        node.attributes.keys.each do |key|
          attributes[node.attributes[key].name.to_sym] = node.attributes[key].value
        end
      end
      if node.children.size > 0
        node.children.each do |child|
          result = xml_node_to_hash(child)

          if child.name == "text"
            unless child.next_sibling || child.previous_sibling
              return result unless attributes
              result_hash[child.name.to_sym] = result
            end
          elsif result_hash[child.name.to_sym]

            if result_hash[child.name.to_sym].is_a?(Object::Array)
              result_hash[child.name.to_sym] << result
            else
              result_hash[child.name.to_sym] = [result_hash[child.name.to_sym]]
            end
          else
            result_hash[child.name.to_sym] = result
          end
        end
        if attributes
          #add code to remove non-data attributes e.g. xml schema, namespace here
          #if there is a collision then node content supersets attributes
          result_hash = attributes.merge(result_hash)
        end
        result_hash
      else
        attributes
      end
    else
      node.content.to_s
    end
  end

  def items(hash)
    items = []
    items = AtomItems.items(hash) if @input_format == 'atom'
    items = RssItems.items(hash) if @input_format == 'rss'
    items
  end
end