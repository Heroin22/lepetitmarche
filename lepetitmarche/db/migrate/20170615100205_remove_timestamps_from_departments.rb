class RemoveTimestampsFromDepartments < ActiveRecord::Migration
  def change
    remove_column :departments, :created_at, :string
    remove_column :departments, :updated_at, :string
  end
end
