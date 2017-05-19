defmodule Logitpho.User do
  use Logitpho.Web, :model

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :email_confirmation, :string, virtual: true
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :last_name, :email, :password])
    |> validate_length(:first_name, min: 3, max: 100)
    |> validate_length(:last_name, min: 3, max: 100)
    |> validate_length(:email, min: 3, max: 100)
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:email_confirmation, :password_confirmation])
    |> validate_required([:email_confirmation, :password_confirmation])
    |> validate_confirmation(:email)
    |> validate_confirmation(:password)
    |> put_hash_password()
  end

  def update_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:password_confirmation])
    |> validate_required([:password_confirmation])
    |> validate_confirmation(:password)
    |> put_hash_password()
  end

  def put_hash_password(struct) do
    case struct do
      %Ecto.Changeset{ valid?: true, changes: %{ password: pass }} ->
        put_change(struct, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        struct
    end
  end
end
