namespace :words do
  desc "Delete Word dups"
  task :remove_dups => :environment do
    puts "Removing Word duplicates..."
    duplicate_row_values = Word.select('name, definition, count(*)').group('name, definition').having('count(*) > 1').pluck(:name, :definition)

    duplicate_row_values.each do |name, definition|
      puts Word.where(name: name, definition: definition).order(id: :desc)[1..-1].map(&:destroy)
    end
  end
end
