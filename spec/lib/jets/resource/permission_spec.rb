describe Jets::Resource::Permission do
  let(:permission) { Jets::Resource::Permission.new(replacements, associated_resource) }
  let(:associated_resource_type) { "AWS::Events::Rule" }
  let(:associated_resource) do
    definition = {
      "{namespace}EventsRule1": {
        type: associated_resource_type,
        properties: {
          schedule_expression: "rate(10 hours)",
          state: "ENABLED",
          targets: [{
            arn: "!GetAtt {namespace}LambdaFunction.Arn",
            id: "{namespace}RuleTarget"
          }]
        } # closes properties
      }
    }
    Jets::Resource.new(definition, replacements)
  end
  let(:replacements) { {namespace: "HardJobDig"} }

  context "raw cloudformation definition" do
    it "permission" do
      expect(permission.logical_id).to eq "HardJobDigPermission1"
      properties = permission.properties
      # pp properties # uncomment to debug
      expect(properties["Principal"]).to eq "events.amazonaws.com"
      expect(properties["SourceArn"]).to be nil
    end
  end

  context "raw cloudformation definition for cognito user pool resource" do
    let(:associated_resource_type) { "AWS::Cognito::UserPool" }
    it "permission" do
      expect(permission.logical_id).to eq "HardJobDigPermission1"
      properties = permission.properties
      # pp properties # uncomment to debug
      expect(properties["Principal"]).to eq "cognito-idp.amazonaws.com"
      expect(properties["SourceArn"]).to be nil
    end
  end

  context "raw cloudformation definition for cognito user pool sub resource" do
    let(:associated_resource_type) { "AWS::Cognito::UserPoolDomain" }
    it "permission" do
      expect(permission.logical_id).to eq "HardJobDigPermission1"
      properties = permission.properties
      # pp properties # uncomment to debug
      expect(properties["Principal"]).to eq "cognito-idp.amazonaws.com"
      expect(properties["SourceArn"]).to be nil
    end
  end

  context "raw cloudformation definition for cognito identity pool resource" do
    let(:associated_resource_type) { "AWS::Cognito::IdentityPool" }
    it "permission" do
      expect(permission.logical_id).to eq "HardJobDigPermission1"
      properties = permission.properties
      # pp properties # uncomment to debug
      expect(properties["Principal"]).to eq "cognito-identity.amazonaws.com"
      expect(properties["SourceArn"]).to be nil
    end
  end

  context "raw cloudformation definition for cognito identity pool sub resource" do
    let(:associated_resource_type) { "AWS::Cognito::IdentityPoolRoleAttachment" }
    it "permission" do
      expect(permission.logical_id).to eq "HardJobDigPermission1"
      properties = permission.properties
      # pp properties # uncomment to debug
      expect(properties["Principal"]).to eq "cognito-identity.amazonaws.com"
      expect(properties["SourceArn"]).to be nil
    end
  end

end

