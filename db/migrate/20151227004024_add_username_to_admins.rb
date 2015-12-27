class AddUsernameToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :username, :string, null: false, default: ""
  end
end
