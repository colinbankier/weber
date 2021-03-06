defmodule Weber.App do
  use GenServer.Behaviour

  @moduledoc """
    Weber web application initial process (Starts cowboy, parse routes, and etc...)
  """

  defrecord WeberApp,
    name:   nil, 
    routes: nil,
    config: nil,
    root:   nil,
    static_dir: nil,
    views_dir:  nil
    
  def start_link(app_name, routes, root_directory, config) do
    :gen_server.start_link({:local, app_name}, __MODULE__, [app_name, routes, root_directory, config], [])
  end

  def init([app_name, routes, root_directory, config]) do
    :gen_server.cast(:erlang.self(), :init)
    :ets.new(:req_storage, [:named_table, :public, :set, {:keypos, 1}])
    { :ok, WeberApp.new name: app_name, 
                        routes: routes, 
                        root: root_directory, 
                        config: config,
                        static_dir: root_directory ++ '/public/',
                        views_dir:  root_directory ++ '/lib/views/' }
  end

  def handle_cast(:init, state) do
    Cowboy.start(state.name, state.config)
    {:noreply, state}
  end

  def handle_call(:routes, _from, state) do
    { :reply, state.routes, state }
  end

  def handle_call(:config, _from, state) do
    { :reply, state.config, state }
  end

  def handle_call(:root, _from, state) do
    { :reply, state.root, state }
  end

  def handle_call(:static, _from, state) do
    { :reply, state.static_dir, state }
  end

  def handle_call(:views, _from, state) do
    { :reply, state.views_dir, state }
  end

end