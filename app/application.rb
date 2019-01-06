class Application
  eggs = Item.new("Eggs",5.34)
  bacon = Item.new("Bacon",6.50)
  milk = Item.new("Milk",2.75)
  @@items = [eggs, bacon, milk]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if item =@@items.find do |instance|instance.name == item_name end
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status=404
      resp.write "Route not found"
    end
    resp.finish
  end
end
