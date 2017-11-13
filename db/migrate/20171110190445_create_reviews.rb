class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :product, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :description
      t.string :rating
      t.timestamps null: false
    end
  end
end


# Product.connection.execute("UPDATE products SET price = 'free' WHERE 1=1")
# Reviews.connection.execute("GRANT ALL PRIVILEGES ON TABLE reviews IN SCHEMA public TO labber")
Reviews.connection.execute("GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO labber")