When(/^I configure the Conjur username$/) do
  ENV['CONJUR_AUTHN_LOGIN'] = 'admin'
end

Then(/^I can connect to Conjur$/) do
  conjur = Conjur::Authn.connect nil, noask: true
  expect(conjur).to be
  expect(conjur.username).to eq('admin')
end

Then(/^I cannot connect to Conjur$/) do
  begin
    Conjur::Authn.connect nil, noask: true
    raise "I connected to Conjur without knowing my username. How can this be?"
  rescue Conjur::Authn::NoCredentialsError
  end
end

Then(/^I can list Conjur resources$/) do
  conjur = Conjur::Authn.connect nil, noask: true
  expect(conjur.token).to be
  expect(conjur.token['data']).to eq('admin')
  resources = conjur.resources
  expect(resources.map(&:resource_id)).to include("cucumber:service:pubkeys-1.0/public-keys")
end
