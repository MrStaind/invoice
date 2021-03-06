class Organization < ActiveRecord::Base 
  RESTRICTED_SCHEMANAMES = %w(www api)
  resourcify
   
  has_many :costcenters
	has_many :invoices
  has_many :members
  has_many :users, through: :members 

 validates :name, presence: true
                                     
   validates :schema_name, presence: true,
                          uniqueness: { case_sensitive: false },
                          format: { with: /\A[\w\‐]+\Z/i , message: 'contains invalid characters'},
                          exclusion: { in: RESTRICTED_SCHEMANAMES, message: 'restricted'}

# after_create :create_tenant
before_validation :downcase_schema_name

  private
    def create_tenant
      Apartment::Tenant.create(schema_name)
    end

    def downcase_schema_name
      self.schema_name = schema_name.try {
        downcase.tr(" ", "_")
      }
    end
end