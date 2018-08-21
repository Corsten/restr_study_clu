class Parser
  def parse(doc)
    doc.root ? prepare_items(xml_parse(doc.root), input_format(doc)) : {}
  end

  def input_format(doc)
    input_format = 'atom' if doc.root.name == 'feed'
    input_format = 'rss' if doc.root.name == 'rss'
    input_format
  end

  def xml_parse(node)
    if node.element?
      result_data = {}
      if node.attributes != {}
        attributes = {}
        node.attributes.keys.each do |key|
          attributes[node.attributes[key].name.to_sym] = node.attributes[key].value
        end
      end
      if node.children.size > 0
        node.children.each do |child|
          result = xml_parse(child)

          if child.name == "text"
            unless child.next_sibling || child.previous_sibling
              return result unless attributes
              result_data[child.name.to_sym] = result
            end
          elsif result_data[child.name.to_sym]

            if result_data[child.name.to_sym].is_a?(Object::Array)
              result_data[child.name.to_sym] << result
            else
              result_data[child.name.to_sym] = [result_data[child.name.to_sym]]
            end
          else
            result_data[child.name.to_sym] = result
          end
        end
        if attributes
          result_data = attributes.merge(result_data)
        end
        result_data
      else
        attributes
      end
    else
      node.content.to_s
    end
  end

  def prepare_items(data, input_format)
    prepared_data = Atom.prepare_items(data) if input_format == 'atom'
    prepared_data = Rss.prepare_items(data) if input_format == 'rss'
    prepared_data
  end
end