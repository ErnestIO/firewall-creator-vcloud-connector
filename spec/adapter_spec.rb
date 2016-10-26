# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require_relative 'spec_helper'

describe 'vcloud_firewall_creator_microservice' do
  let!(:provider) { double('provider', supu: 'supu') }

  before do
    allow_any_instance_of(Object).to receive(:sleep)
    require_relative '../adapter'
  end

  describe '#create_firewall' do
    let!(:data)   do
      { firewall_type: 'vcloud',
        router_name: 'adria-vse',
        client_name: 'r3labs-development',
        datacenter_name: 'r3-acidre',
        datacenter_username: 'acidre@r3labs-development',
        rules: [] }
    end
    let!(:event)      { double('event', data: data) }
    let!(:datacenter) { double('datacenter', router: router) }
    let!(:router)     { double('router', update_service: true) }

    before do
      allow_any_instance_of(Provider).to receive(:initialize).and_return(true)
      allow_any_instance_of(Provider).to receive(:datacenter).and_return(datacenter)
    end

    it 'create a firewall on vcloud' do
      expect(create_firewall(data)).to eq 'firewall.create.vcloud.done'
    end
  end
end
