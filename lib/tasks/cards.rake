namespace :cards do
  desc "operations to be performed on cars"

  task :destroy_all => :environment do
    Card.destroy_all
  end

end
