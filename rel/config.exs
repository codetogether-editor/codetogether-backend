use Mix.Releases.Config,
    default_release: :default,
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html

# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"nqi8xHaIRTuWH&(p@uy0rKMEnDcM`z<zbvi7R!},;??A[T*5E5N?8.gQe-zjOF_n"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"nqi8xHaIRTuWH&(p@uy0rKMEnDcM`z<zbvi7R!},;??A[T*5E5N?8.gQe-zjOF_n"
  plugin DistilleryPackage
end

release :codetogether do
  set version: current_version(:codetogether)
  set commands: [
    task: "rel/commands/task"
  ]
end
