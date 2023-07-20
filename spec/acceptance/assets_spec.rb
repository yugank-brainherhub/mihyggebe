# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Assets' do
  include_context 'api request'
  header 'Authorization', :provider_authorization

  post '/api/assets' do
    example 'FAILURE: morethan one image cannot be uploaded for the first time' do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, 
         assets: [Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), Rack::Test::UploadedFile.new('spec/factories/test.jpg', 'image/jpg')])
      status.should == 422
    end
  end

  post '/api/assets' do
    example 'SUCCESS: one image and one video is mandatory for the first time' do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, 
         assets: [Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), Rack::Test::UploadedFile.new('spec/factories/test.mp4', 'video/mp4')])
      status.should == 200
    end
  end

  post '/api/assets' do
    example 'FAILURE: one video and one image is mandatory for the first time' do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, 
         assets: [Rack::Test::UploadedFile.new('spec/factories/test.mp4', 'video/mp4')])
      status.should == 422
    end
  end

  post '/api/assets' do
    before do
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), 
                    asset_type: 'image/jpeg', 
                    assetable_id: senior_living.id, 
                    assetable_type: 'Care')
    end
    example 'SUCCESS: provider upload assets with type upate' do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, type: 'update',
         assets: {
          '0'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'),
            sort: 3
          },
          '1' => {
            id: Asset.first.id,
            file: Rack::Test::UploadedFile.new('spec/factories/test.jpg', 'image/jpeg'),
            sort: 5
          } 
        }
      )

      status.should == 200
    end
  end

  post '/api/assets' do
    before do
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), 
                    asset_type: 'image/jpeg', 
                    assetable_id: senior_living.id, 
                    assetable_type: 'Care')
    end
    example 'FAILURE: duplicate sort number for file update' do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, type: 'update',
         assets: {
          '0'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'),
            sort: 3
          },
          '1' => {
            id: Asset.first.id,
            file: Rack::Test::UploadedFile.new('spec/factories/test.jpg', 'image/jpeg'),
            sort: 5
          },
          '2'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'),
            sort: 3
          },
        }
      )
      JSON.parse(response_body)["files_failed"].flatten.count > 1

      status.should == 200
    end
  end

  post '/api/assets' do
    before do
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), 
                    asset_type: 'image/jpeg', 
                    assetable_id: senior_living.id, 
                    assetable_type: 'Care')
    end
    example "FAILURE: Morethan 10 files can't uploaded" do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, type: 'update',
         assets: {
          '0'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'),
            sort: 2
          },
          '1' => {
            id: Asset.first.id,
            file: Rack::Test::UploadedFile.new('spec/factories/test.jpg', 'image/jpeg'),
            sort: 3
          },
          '2'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'),
            sort: 4
          },

          '3'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'),
            sort: 5
          },

          '4'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'),
            sort: 6
          },

          '5'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'),
            sort: 7
          },
          '6' => {
            id: Asset.first.id,
            file: Rack::Test::UploadedFile.new('spec/factories/test.jpg', 'image/jpeg'),
            sort: 8
          },
          '7'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'),
            sort: 9
          },

          '8'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'),
            sort: 10
          },

          '9'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'),
            sort: 12
          }
        })
      JSON.parse(response_body)["files_failed"].flatten.count ==1
      status.should == 200
    end
  end

  post '/api/assets' do
    before do
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), 
                    asset_type: 'image/jpeg', 
                    assetable_id: senior_living.id, 
                    assetable_type: 'Care',
                    sort: 1)
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/test.mp4', 'video/mp4'), 
              asset_type: 'video/mp4', 
              assetable_id: senior_living.id, 
              assetable_type: 'Care',
              sort: 1)
    end
    example 'FAILURE: morethan one video not allowed' do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, type: 'update',
         assets: {
          '0'=> {
            file: Rack::Test::UploadedFile.new('spec/factories/test.mp4', 'video/mp4'),
            sort: 2
          }
        }
      )
      JSON.parse(response_body)["files_failed"].flatten.count > 1

      status.should == 200
    end
  end


  post '/api/assets' do
    before do
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), 
                    asset_type: 'image/jpeg', 
                    assetable_id: senior_living.id, 
                    assetable_type: 'Care',
                    sort: 1)
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/check.png', 'image/png'), 
                    asset_type: 'image/png', 
                    assetable_id: senior_living.id, 
                    assetable_type: 'Care',
                    sort: 2)
    end
    example "SUCCESS: swap sorting order for two images" do
      do_request(assetable_type: 'care', 
         assetable_id: senior_living.id, type: 'update',
         assets: {
          '0'=> {
            id: Asset.first.id,
            sort: 2
          },
          '1' => {
            id: Asset.last.id,
            sort: 1
          }
        })
      JSON.parse(response_body)["files_failed"].flatten.count == 0
      status.should == 200
    end
  end

  put '/api/assets/:id' do
    before do
      FactoryBot.create(:care, user: provider)
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), 
                    asset_type: 'image/jpeg', 
                    assetable_id: Care.first.id, 
                    assetable_type: 'Care')
    end
    example 'provider: update image order for uploaded images' do
      do_request(id: Asset.first.id , asset: { sort: 3 } )

      status.should == 200
    end
  end

  delete '/api/assets/:id' do
    before do
      FactoryBot.create(:care, user: provider)
      FactoryBot.create(:asset, file: Rack::Test::UploadedFile.new('spec/factories/download.jpeg', 'image/jpeg'), 
                          asset_type: 'image/jpeg', 
                          assetable_id: Care.first.id, 
                          assetable_type: 'Care')
    end
    example 'provider: Delete images/videos of care' do
      do_request(id: Asset.first.id)

      status.should == 204
    end
  end
end
