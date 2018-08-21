class XmlParser
  def self.can_pars?(doc)
    false
  end

  def self.parse(node)
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
          result = parse(child)

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
end