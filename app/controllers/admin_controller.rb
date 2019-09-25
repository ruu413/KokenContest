class AdminController < ApplicationController
  
  before_action :basic_auth_admin, only: [:index]
  def index
    @entries = Entry.all
  end
  def update
    entries = params["entries"]
    entries.each do |i,entry|
      ent = Entry.find(entry[:id])
      ent.update(order:entry[:order],is_evaluated:entry[:is_evaluated])
    end
  end
end
