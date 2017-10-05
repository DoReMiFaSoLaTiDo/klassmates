module ProfilesHelper

  def thumbnail_image(user)
    return image_tag user.image.url(:thumbnail) if user && user.image.present?
    cl_image_tag("unilorin_logo_only_zoar3v.jpg", :width=>60, :crop=>"scale")
  end

  def standard_image(user)
    return image_tag user.image.url(:standard) if user && user.image.present?
    cl_image_tag("unilorin_logo_only_zoar3v.jpg", :width=>60, :crop=>"scale")
  end

  def user_birthday(user)
    return user.birthday.strftime('%B, %e') if user && user.birthday.present?
    "Not Set"
  end

  def user_contribution_lcy(user)
    return number_to_currency(user.contribution_lcy, unit: "=N= ") if user && user.contribution_lcy.present?
    number_to_currency(0, unit: "NGN")
  end

  def user_contribution_fcy(user)
    return number_to_currency(user.contribution_fcy) if user && user.contribution_fcy.present?
    number_to_currency(0)
  end

  def profile_phone(profile)
    return number_to_phone(profile.user_phone.gsub(/[^\w\s]/, '')) if profile && profile.user_phone.present?
  end

  def display_transaction(tran)
    class_effects = { "unverified" => 'warning', "verified" => 'success', "deleted" => 'danger' }
    '<tr class="alert alert-#{class_effects[<%= tran.status %>]}">
      <td><%= tran.created_at.strftime("%b %d, %Y") %></td>
      <td><%= number_with_delimiter(tran.amount) %></td>
      <td><%= tran.currency %></td>
    </tr>'.html_safe
  end

  def display_transactions(collection)
    class_effects = { "unverified" => 'warning', "verified" => 'success', "deleted" => 'danger' }
    content_tag(:tbody, class: "list") do
      collection.collect do |member|
        concat(content_tag(:tr, class:  "alert alert-#{class_effects[member.status]}") do
          concat(content_tag(:td) do
            member.tran_date.strftime("%b %d, %Y")
          end)
          concat(content_tag(:td) do
            number_with_precision(member.amount, precision: 2, delimiter: ',')
          end)
          concat(content_tag(:td) do
            member.currency
          end)
        end)
      end
    end
  end

  def attributes(resource_class)
    resource_class.to_s.capitalize.constantize.attribute_names - send("unwanted_#{resource_class}_attribs")
  end

  def is_admin?(usr)
    usr.role_id == 1
  end

  def is_advocate?(usr)
    usr.role_id == 2
  end

  def is_strategist?(usr)
    usr.role_id == 3
  end

  def is_member?(usr)
    usr.role_id == 4
  end

  private

    def unwanted_user_attribs
      %w(id created_at updated_at encrypted_password password_confirmation sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip reset_password_sent_at remember_created_at auth_token reset_password_token)
    end

end
