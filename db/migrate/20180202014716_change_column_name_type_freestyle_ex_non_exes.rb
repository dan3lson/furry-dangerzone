class ChangeColumnNameTypeFreestyleExNonExes < ActiveRecord::Migration
  def change
    rename_column :freestyle_ex_non_exes, :type, :kind
  end
end
