module Digitalocean
  class Base
    include EmmyHttp::Model
    adapter EmmyHttp::Client::Adapter
    url "https://api.digitalocean.com"
  end

  class Account < Base
    # Get User Information
    get '/v2/account', as: 'info'
    # SSH Keys
    class Keys < Base
      # List all Keys
      get '/v2/account/keys', as: 'all'
      # Create a new Key
      post '/v2/account/keys', as: 'new'
      # Retrieve an existing Key
      get '/v2/account/keys/{/id}', as: 'retrieve'
      # Update a Key
      put '/v2/account/keys/{/id}', as: 'update'
      # Destroy a Key
      delete '/v2/account/keys/{/id}', as: 'destroy'
    end
  end

  class Actions < Base
    # List all Actions
    get '/v2/actions', as: 'all'
    # Retrieve an existing Action
    get '/v2/actions/{/id}', as: 'retrieve'
  end

  class Domains < Base
    # List all Domains
    get '/v2/domains', as: 'all'
    # Create a new Domain
    post '/v2/domains', as: 'new'
    # Retrieve an existing Domain
    get '/v2/domains/{/name}', as: 'retrieve'
    # Delete a Domain
    delete '/v2/domains/{/name}', as: 'delete'

    class Records < Base
      # List all Domain Records
      get '/v2/domains/{/name}/records', as: 'all'
      # Create a new Domain Record
      post '/v2/domains/{/name}/records', as: 'new'
      # Retrieve an existing Domain Record
      get '/v2/domains/{/name}/records/{/record}', as: 'retrieve'
      # Update a Domain Record
      put '/v2/domains/{/name}/records/{/record}', as: 'update'
      # Delete a Domain Record
      delete '/v2/domains/{/name}/records/{/record}', as: 'delete'
    end
  end

  class Droplets < Base
    # Create a new Droplet
    post '/v2/droplets',       as: 'new'
    # Retrieve an existing Droplet by id
    get  '/v2/droplets/{/id}', as: 'show'
    # List all Droplets
    get  '/v2/droplets',       as: 'all'
    # List all available Kernels for a Droplet
    get  '/v2/droplets/{/id}/kernels',   as: 'kernels'
    # List snapshots for a Droplet
    get  '/v2/droplets/{/id}/snapshots', as: 'snapshots'
    # List backups for a Droplet
    get  '/v2/droplets/{/id}/backups',   as: 'backups'
    # List actions for a Droplet
    get  '/v2/droplets/{/id}/actions',   as: 'actions'
    # Delete a Droplet
    delete '/v2/droplets/{/id}', as: 'delete'
    # List Neighbors for a Droplet
    get  '/v2/droplets/{/id}/neighbors', as: 'neighbors'
    # List all Droplet Neighbors
    get  '/v2/reports/droplet_neighbors', as: 'droplet_neightbors'
    # List Droplet Upgrades
    get  '/v2/droplet_upgrades', as: 'droplet_upgrades'
    # Execute an Action
    post '/v2/droplets/{/id}/actions', as: 'execute_action'
    # Retrive a Droplet Action
    post '/v2/droplets/{/id}/actions/{/action}', as: 'retrieve_action'
  end

  class Images < Base
    # List all images
    get '/v2/images', as: 'all'
    # List all Distribution Images
    get '/v2/images?type=distribution', as: 'distribution_images'
    # List all Application Images
    get '/v2/images?type=application', as: 'application_images'
    # List a User's Images
    get '/v2/images?private=true', as: 'private_images'
    # Retrieve an existing Image by id
    get '/v2/images/{/id}', as: 'retrieve'
    # Retrieve on existing Image by slug
    get '/v2/images/{/slug}', as: 'retrieve_by_slug'
    # List all actions for an image
    get '/v2/images/{/id}/actions', as: 'actions'
    # Update an Image
    put '/v2/images/{/id}', as: 'update'
    # Delete an Image
    delete '/v2/images/{/id}', as: 'delete'
    # Execute an Action
    post '/v2/images/{/id}/actions', as: 'execute_action'
    # Retrieve an existing Image Action
    get '/v2/images/{/id}/actions/{/image}', as: 'retrieve_action'
  end

  class Regions < Base
    # List all Regions
    get '/v2/regions', as: 'all'
  end

  class Sizes < Base
    # List all Sizes
    get '/v2/sizes', as: 'all'
  end
end
