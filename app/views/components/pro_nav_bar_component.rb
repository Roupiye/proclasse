# frozen_string_literal: true

class ProNavBarComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::ButtonTo

  attr_accessor :user

  def initialize(user: nil)
    @user = user
  end

  def view_template
    Navbar(:base_200, class: "shadow-md") { |navbar|
      div(class: "flex max-w-5xl w-full mx-auto") {
        navbar.start {
          link_to(root_path) {
            Button(:ghost, class: "text-xl") {"PC"}
          }


          Menu(:horizontal, class: "px-1") { |menu|
            if user
              if user.professor?
                if user.selected_room
                  menu.item { Link(href: room_path(user.selected_room)) { "Alunos" } }
                  menu.item { Link(href: tasks_path) { "Tarefas" } }
                end
                menu.item { Link(href: challenges_path) { "Desafios" } }
              else
                if user.selected_room
                  menu.item { Link(href: root_path) { "Tarefas" } }
                end
              end
            end
          }
        }

        navbar.end(class: "flex") { profile_dropdown }
      }
    }
  end

  def profile_dropdown
    Dropdown(:end) { |dropdown|
      dropdown.button(:ghost, class: "mb-1") {
        if user
          user.name
        else
          "Perfil"
        end
      }

      dropdown.menu(:base_100, class: "rounded-box w-52 shadow z-50") { |menu|
        if user
          if user.professor.nil?
            menu.item { link_to("Virar Professor", become_teacher_path, data: { "turbo-method": :post }) }
          else
            menu.item { link_to(change_context_path , class: "btn btn-secondary btn-sm mb-1", data: { "turbo-method": :post }) { user.context } }
          end

          if user.selected_room
            menu.item { link_to(select_room_path(user.selected_room, params: {destroy: true}) , class: "mb-1 btn btn-error btn-sm",) { "De-Selecionar Turma" } }
          end

          menu.item { link_to("Logout", Current.session, data: { "turbo-method": :delete }) }
        else
          menu.item { link_to("Login", sign_in_path) }
        end
      }
    }
  end
end
