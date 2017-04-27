module InventoriesHelper
  
  def inventory_setting_page_select
    Inventory.all.collect { |i| [i.iname] }
  end
end
