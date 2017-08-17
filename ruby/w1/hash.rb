class MyHashSet
  attr_reader :store

  def initialize
    @store = Hash.new
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.has_key?(el)
  end

  def delete(el)
    in_hash = false
    if @store.include?(el)
      @store.delete(el)
      in_hash = true
    end

    in_hash
  end

  def to_a
    # res = []
    @store.to_a
  end

  def union(set2)
    @store.merge(set2.store)
  end

  def intersection(set2)
    res = Hash.new
    @store.each do |key,value|
      res[key] = value if set2.store.include?(key)
    end

    res
  end

  def minus(set2)
    res = Hash.new
    @store.each do |key,value|
      res[key] = value unless set2.store.include?(key)
    end

    res
  end

end

mh = MyHashSet.new
mh.insert("hello")
mh.insert("goodbye")
mh.insert("Tom")

mh2 = MyHashSet.new
mh2.insert("very")
mh2.insert("hello")
mh2.insert("Bob")

p mh.union(mh2)
p mh.intersection(mh2)
p mh.minus(mh2)
