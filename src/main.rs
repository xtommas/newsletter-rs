use newsletter::startup::Application;
use newsletter::{
    configuration::get_configuration, telemetry::get_subscriber, telemetry::init_subscriber,
};

#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    // Logging
    let subscriber = get_subscriber("newsletter".into(), "info".into(), std::io::stdout);
    init_subscriber(subscriber);

    // Read configuration and panic if it's not possible
    let configuration = get_configuration().expect("Failed to read configuration");

    let application = Application::build(configuration).await?;
    application.run_until_stopped().await?;
    Ok(())
}
