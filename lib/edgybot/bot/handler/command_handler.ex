defmodule Edgybot.Bot.Handler.CommandHandler do
  @moduledoc false

  require Logger
  alias Edgybot.Bot.{Command, CommandRegistrar}

  def handle_command(%{id: id, token: token} = interaction)
      when is_integer(id) and is_binary(token) do
    command_name = interaction.data.name

    Logger.debug("Handling command #{command_name}...")

    matching_command = CommandRegistrar.get_command_module(command_name)

    case matching_command do
      nil -> :noop
      _ -> Command.handle_interaction(matching_command, interaction)
    end
  end
end
