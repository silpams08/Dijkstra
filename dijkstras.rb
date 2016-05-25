def dijkstras(nodes, source_node)
    distance = []
    previous = []
    visited_nodes = []
    unvisited_nodes = []
    distance[source_node] = 0
    nodes.each_index do |i| 
        if i != source_node
            distance[i] = INFINITY
            previous[i] = nil 
        end
        unvisited_nodes.push i 
    end
    current_node = source_node
    while unvisited_nodes or current_node

        unvisited_nodes.delete current_node
        visited_nodes.push current_node
        array = nodes[current_node]
        near_distance = array.select { |x| x > 0 }
        neighbors = near_distance.map { |x| array.index x }
        neighbors.each do |v|
            dist = distance[current_node] + nodes[current_node][v]
           if dist < distance[v]
              distance[v] = dist
              previous[v] = distance[current_node]
          end
        end
      temp_array = distance.select { |x| !visited_nodes.include? (distance.index(x)) }
      min = temp_array.min
      current_node = distance.index min
      if !current_node
        unvisited_nodes = nil
      end
      if !unvisited_nodes
        current_node = nil
      end
    end
    return [distance, previous]
end 

def shortest_path(nodes, x, y)

    array = dijkstras(nodes, x)

    distance = array[0]
    previous = array[1]
	dest=y
    path = []
    while previous[y]
        path.push (y)
        y = distance.index(previous[y])
    end

    path.push (x)
    puts " short distance from node "+x.to_s+" to "+dest.to_s+" is "+distance[dest].to_s
    puts " shortest path from "+dest.to_s+" to "+x.to_s+" is "+path.to_s
end


  INFINITY = 500
  nodes = [
    [0, 7, 9, 0, 0, 14],
    [7, 0, 10, 15, 0, 0],
    [9, 10, 0, 11, 0, 2],
    [0, 15, 11, 0, 6, 0],
    [0, 0, 0, 6, 0, 9],
    [14, 0, 2, 0, 9, 0]
]
puts "enter source node" 
source=gets.to_i
puts "enter destination node" 
destination=gets.to_i
		
shortest_path(nodes, source, destination)