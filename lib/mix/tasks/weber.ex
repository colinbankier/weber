defmodule Mix.Tasks.Weber do

    @moduledoc """

       Create a new weber project template.

       Usage:

         mix weber /home/user/myWebApp - Creates myWebApp directory with weber project skeleton.
         mix weber --version - Prints weber version.
    """

    @shortdoc "Create a new weber project"

    use Mix.Task
    
    import Path
    import File
    import :file
    import Mix.Generator

    @version Weber.Mixfile.project[:version]
    
    def run([]) do
        usage
    end

    def run(["--help"]) do
        usage
    end

    def run(["--run"]) do
        # get current application's name
        app = Mix.project[:app]
        # get application's root directory
        {:ok, app_root_dir} = get_cwd()
    end

    def run(["--version"]) do
        Mix.shell.info "Weber v#{@version}"
    end

    def run([args]) do
        # new project's root directory
        directoryName = args
        # create project directory
        case mkdir(directoryName) do
            :ok -> :ok
            err -> :io.format("[Weber error] Can't create project directory. Error: ~p~n", [err])
        end

        #
        # create project skeleton
        #
        path = absname directoryName
        basePath = basename directoryName

        create_directory path <> <<"/lib">>
        create_directory path <> <<"/lib/static">>
        create_directory path <> <<"/lib/views">>
        create_directory path <> <<"/lib/models">>
        create_directory path <> <<"/lib/controllers">>
        create_directory path <> <<"/lib/helpers">>

        create_file path <> <<"/README.md">>, (readme basePath)
        create_file path <> <<"/.gitignore">>, gitignore
        create_file path <> <<"/mix.exs">>, (project basePath)
        create_file path <> <<"/lib/app.ex">>, (app basePath)
        create_file path <> <<"/lib/route.ex">>, route
        create_file path <> <<"/lib/config.ex">>, config

    end

    def route do
        """
        defmodule Route do
            import Weber.Route
        end
        """
    end

    def readme(basePath) do
        """ 
        #{basePath}
        =====

        """
    end

    def gitignore do
        """
        /ebin
        /deps
        erl_crash.dump
        """
    end

    def project(projectName) do
        proj = String.capitalize projectName

        """
        defmodule #{proj}.Mixfile do
            use Mix.Project

            def project do
                [ 
                    app: :#{projectName},
                    version: "0.0.1",
                    deps: deps,
                    compile_path: "ebin"
                ]
            end

            def application do
                [
                    applications: [:weber],
                ]
            end

            defp deps do
                [ 
                    { :weber, github: "0xAX/weber", compile: "mix deps.get && mix compile" } 
                ]
            end
        end
        """
    end

    def app(projectName) do
        proj = String.capitalize projectName        
        """
        defmodule #{proj} do
             
        end
        """
    end 

    def config do
        """
        defmodule Config do 
            
            use ExConfig.Object

            defproperty web_server_http_host, default: "localhost"
            defproperty web_server_http_port, default: 8800
        
        end
    """
    end

    def usage do
        """
        Usage:

          mix weber /home/user/testWebApp -- creates new weber web application
          mix weber --version -- shows weber version
          mix weber --help    -- show weber help
          mix weber --run     -- runs current weber web application
        """
    end
end