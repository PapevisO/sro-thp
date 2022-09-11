class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, limit: 100
    add_index  :users, :username, unique: true

    def add_address_fields(table, **options)
      %i[
        first_name
        last_name
        salutation
        country
        state
        city
        address_line
        zipcode
        phone
      ].each do |f|
        add_column table, f, :string, limit: 60, **options
      end
    end

    add_address_fields(:users)
  end
end
