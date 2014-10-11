class Customer < ActiveRecord::Base
validates :name,:mobile,:address,:check_in_date,:no_of_days,:room_type, :presence => {notice: "fields cant be blank"}
end
