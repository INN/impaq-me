## impaq backend
````
    Prefix Verb   URI Pattern                Controller#Action
    shares GET    /shares(.:format)          shares#index
           POST   /shares(.:format)          shares#create
 new_share GET    /shares/new(.:format)      shares#new
edit_share GET    /shares/:id/edit(.:format) shares#edit
     share GET    /shares/:id(.:format)      shares#show
           PATCH  /shares/:id(.:format)      shares#update
           PUT    /shares/:id(.:format)      shares#update
           DELETE /shares/:id(.:format)      shares#destroy
````
