class RemoteCard < ActiveResource::Base  
  self.site = "http://xmascard.herokuapp.com/"
  self.element_name = "card"
end