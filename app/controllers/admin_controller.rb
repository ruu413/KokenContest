class AdminController < ApplicationController
  def index
    @entries = Entry.all
  end
  def update
    entries = params["entries"]
    entries.each do |i,entry|
      ent = Entry.find(entry[:id])
      ent.update(order:entry[:order])
    end
  end
end
