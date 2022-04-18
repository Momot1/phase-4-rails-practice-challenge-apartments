class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :rent

  belongs_to :apartment
  belongs_to :tenant
end
