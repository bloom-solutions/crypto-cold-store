module Btc
  class SendImportRequest

    extend LightService::Action
    expects :bitcoiner_client, :public_address
    promises :import_address_response

    ACCOUNT = ""
    RESCAN = false

    executed do |c|
      c.import_address_response = c.bitcoiner_client.request(
        "importaddress",
        c.public_address,
        ACCOUNT,
        RESCAN
      )
    end

  end
end
