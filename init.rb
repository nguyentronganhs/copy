Redmine::Plugin.register :redhopper do
  name 'Redhopper plugin'
  author 'infoPiiaf'
  description 'Kanban boards for Redmine, inspired by Jira Agile (formerly known as Greenhopper), but following its own path.'
  version '0.10.0'
  url 'https://git.framasoft.org/infopiiaf/redhopper.git'
  author_url 'http://www.infopiiaf.fr'

  project_module :kanbans do
    permission :kanbans, { :kanbans => [:index] }, :public => true
  end

  menu :project_menu, :kanbans, { :controller => 'kanbans', :action => 'index' }, :caption => 'Kanbans', :after => :activity, :param => :project_id

  settings :partial => 'settings/kanbans'
end
