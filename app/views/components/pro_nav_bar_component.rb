# frozen_string_literal: true

class ProNavBarComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::ButtonTo

  attr_accessor :user

  def initialize(user: nil)
    @user = user
  end

  def view_template
    Navbar(:base_200, id: "nav-bar", class: "flex shadow-md h-[49px]") { |navbar|
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
                  menu.item { Link(href: tasks_path) { "Tarefas" } }
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
      dropdown.button(:ghost) {
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
            div(class: "flex") {
              menu.item(class: "w-[50%]") { link_to(user.context == "student" ? "#" : change_context_path , class: "btn btn-#{user.context != "student" ? "ghost" : "secondary"} btn-sm mb-1 mr-1", data: { "turbo-method": :post }) { "Estudante" } }
              menu.item(class: "w-[50%]") { link_to(user.context == "professor" ? "#" : change_context_path , class: "btn btn-#{user.context != "professor" ? "ghost" : "secondary"}  btn-sm mb-1 ml-1", data: { "turbo-method": :post }) { "Professor" } }
            }
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
