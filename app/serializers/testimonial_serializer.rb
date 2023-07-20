class TestimonialSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :publish, :testimonial_type, :location, :gender
end
