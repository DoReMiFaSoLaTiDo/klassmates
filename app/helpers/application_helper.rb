module ApplicationHelper
  def full_title(title=" ")
    title.nil? ? "UNILORIN Accounting & Finance | Class of '99" : title

  end

#  def site_logo
#     <%= cl_image_tag("rccg_dark_back_logo_olov3e.png", :width=>20, :crop=>"scale") %>
#  end

  def site_name
    "Klassmates"
  end

  def site_url
    if Rails.env.production?
      "http://www.klassmates.com/"
    else
      "http://localhost:3000"
    end
  end

  def meta_author
    "Michael Fashola"
  end

  def meta_description
    "University of Ilorin Accounting and Finance Class of 1999"
  end

  def meta_keywords
    "University of Ilorin, UNILORIN, Class of 99, Acconting, Finance, Group"
  end

  #returns the full title on a per page basis
  def full_title(page_title)
    site_name if page_title.empty?
  end

  def uk_date_time(get_date)
    DateTime.parse(get_date.to_s).strftime("%a, %d %b %Y %I:%M %p")
  end

  def uk_date(get_date)
    DateTime.parse(get_date.to_s).strftime("%d %b %Y")
  end


end
