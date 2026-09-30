defmodule Mix.Tasks.StartReg.Gen.XpGenTenants do
  @shortdoc "Generate Tenant resources"
  @moduledoc """
  Generate Tenant resources

  Run after `start_reg.add.xp_gen_accounts`

  """

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    # CLAUDE - update code here
  end

end

# Instructions for CLAUDE
#
# We are creating an ash Doman and Resources for Multi-tenancy
#
# Doman: Tenants
# - Resource: Org (organization - the tenant)
# - Resource: Mem (membership - connection between user and org)
#
# Please just create the back-end support, using the postgres data layer.
# Separately, we will setup a Liveview Admin page for Tenants.
#
# Org attributes should include: name, admin(a add_user_id?), timestamps
# Mem attributes should include: org_id, user_id
#
# Also: create seed data for the multi-tenant system:
# - Org - Team1, Team2 (administered by "a@a.com")
# - Mem - Team1 (a@a.com, b@b.com) Team2 (a@a.com, c@c.com)
#
# Related info:
# - https://ash.hexdocs.pm/multitenancy.html
# - Mix.Tasks.StartReg.Gen.XpGenAccounts
