# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout
  include Phlex::Rails::Helpers::ContentFor

  attr_reader :alert, :notice
  attr_accessor :user, :borderless

  def initialize(user: nil,  alert: nil, notice: nil, borderless: false)
    @user = user
    @alert = alert
    @notice = notice
    @borderless = borderless
  end

  def view_template()
    html do
      head do
        title { "ProClasse" }
        meta(name: "turbo-cache-control", content: "no-cache")
        meta(name: "viewport", content: "width=device-width,initial-scale=1")
        meta(name: "apple-mobile-web-app-capable", content: "yes")
        meta(name: "mobile-web-app-capable", content: "yes")
        csrf_meta_tags
        csp_meta_tag
        # = tag.link rel: "manifest", href: pwa_manifest_path(format: :json)
        link(rel: "icon", href: "/icon.png", type: "image/png")
        link(rel: "icon", href: "/icon.svg", type: "image/svg+xml")
        link(rel: "apple-touch-icon", href: "/icon.png")
        # Includes all stylesheet files in app/assets/stylesheets
        stylesheet_link_tag "tailwind",
                            "inter-font",
                            "data-turbo-track": "reload"
        stylesheet_link_tag :app, "data-turbo-track": "reload"
        javascript_importmap_tags
      end
      body(class: "h-screen") do
        render ProNavBarComponent.new(user: user)
        if borderless
          main() {
            yield
          }
        else
          main(class: "max-w-5xl mx-auto mt-14 px-4") {
            p { notice }
            p { alert }
            yield
          }
        end
      end

      if user&.selected_room
        div(
          class: "p-2 fixed bottom-0 right-0 bg-neutral rounded-tl-lg select-none"
        ) { user.selected_room.name }
      end
    end
  end
end
