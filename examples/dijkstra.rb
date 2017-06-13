require_relative 'dijkstra/data'
# See https://github.com/RichOrElse/greedy-dci/blob/master/test/dijkstra_test.rb

# Behaviors

module Map
  def distance_between(a, b)
    @distances[Edge.new(a, b)]
  end

  def distance_of(path)
    Distance[within: self].of(path)
  end
end

module CurrentIntersection
  def neighbors(nearest:)
    east_neighbor = nearest.east_neighbor_of(self)
    south_neighbor = nearest.south_neighbor_of(self)
    [south_neighbor, east_neighbor].compact
  end
end

module DestinationNode
  def shortest_path(from:, within:)
    return [self] if equal? from
    Shortest[from: from, to: self, map: within].path
  end
end

# Contexts

extend Greedy::DCI

Distance = context do |within|
  using within.as Map

  def between(a, b)
    within.distance_between(a, b)
  end

  def of(path)
    path.reverse.each_cons(2).inject(0) { |total, pair| total + between(*pair) }
  end
end

Shortest = context do |from, to, map|
  using from.as CurrentIntersection
  using to.as DestinationNode
  using map.as Map

  def distance
    map.distance_of path
  end

  def path
    _shortest_path + [from]
  end

  private

  def _shortest_path
    from.
      neighbors(nearest: map).
      map { |neighbor| to.shortest_path from: neighbor, within: map }.
      min_by { |path| map.distance_of path }
  end
end
