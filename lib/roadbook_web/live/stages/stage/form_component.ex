defmodule RoadbookWeb.Stages.StageLive.FormComponent do
  use RoadbookWeb, :live_component

  alias Roadbook.Stages

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle></:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="stage-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:data]} type="text" label="Data" />
        <div class="flex justify-center items-center w-full">
          <label
            for="dropzone-file"
            class="flex flex-col justify-center items-center w-full h-64 bg-gray-50 rounded-lg border-2 border-gray-300 border-dashed cursor-pointer hover:bg-gray-100"
          >
            <div class="flex flex-col justify-center items-center pt-5 pb-6">
              <svg
                aria-hidden="true"
                class="mb-3 w-10 h-10 text-gray-400"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                >
                </path>
              </svg>
              <p class="mb-2 text-sm text-gray-500">
                <span class="font-semibold">Click to stage</span> or drag and drop
              </p>
              <p class="text-xs text-gray-500">GPX File</p>
            </div>
            <!-- <.live_file_input stage={@form[:data]} /> -->
          </label>
        </div>

        <:actions>
          <.button phx-disable-with="Saving...">Save Stage</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{stage: stage} = assigns, socket) do
    changeset = Stages.change_stage(stage)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"stage" => stage_params}, socket) do
    changeset =
      socket.assigns.stage
      |> Stages.change_stage(stage_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"stage" => stage_params}, socket) do
    save_stage(socket, socket.assigns.action, stage_params)
  end

  defp save_stage(socket, :edit, stage_params) do
    case Stages.update_stage(socket.assigns.stage, stage_params) do
      {:ok, stage} ->
        notify_parent({:saved, stage})

        {:noreply,
         socket
         |> put_flash(:info, "Stage updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_stage(socket, :new, stage_params) do
    case Stages.create_stage(stage_params) do
      {:ok, stage} ->
        notify_parent({:saved, stage})

        {:noreply,
         socket
         |> put_flash(:info, "Stage created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
