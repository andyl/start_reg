defmodule Mix.Tasks.StartReg.Gen.XpGenAuth do
  @shortdoc "Generate User resources for Auth"
  @moduledoc """
  Generate User resources for Auth
  """

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    # TBD - claude fill in this block
  end
end

# CLAUDE:
# I wasnt to run these mix commands.  In this context, ash_authentication and ash_authentication_phoenix have already been run.
#
# Use uuidv7       mix ash.gen.resource $APP.Accounts.User --uuid-v7-primary-key id --conflicts replace --yes
# Add migration    mix ash.codegen use_uuidv7
# (SHOULD I RUN THE MIGRATION NOW?)
# Add User Slug    mix ash.gen.resource $APP.Accounts.User -a username:ci_string -a slug:ci_string -t --conflicts replace --yes
#
# QUESTION: how do I inject the $APP name??
#
# Then I want to seed a user account!!
#
# mix run -e \"Ash.Seed.seed!($APP.Accounts.User, %{email: ~s(a@a.com), hashed_password: Bcrypt.hash_pwd_salt(~s(12345678))})\"
#
# CLAUDE:
# - show the best way to run these mix tasks
# - update StepHelpers if necessary
#

