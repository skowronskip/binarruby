 class MessagePresenter < SimpleDelegator
   def day_of_week
     created_at.strftime("%A")
   end
 end