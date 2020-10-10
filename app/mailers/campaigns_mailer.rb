# frozen_string_literal: true

class CampaignsMailer < ApplicationMailer
  helper :application
  helper :campaigns

  def campaign_email(campaign, membership, ics)
    @membership = membership
    @campaign = campaign

    prepare_event_variables campaign

    attachments['event.ics'] = ics if ics.present?

    mail(
      to: @membership.user.email,
      subject: campaign.subject
    )
  end

  private

  def prepare_event_variables(campaign)
    return if campaign.rsvp_event.blank?

    @event = campaign.rsvp_event
    @rsvp = Rsvp.find_or_create_by(
      rsvp_event: @event,
      membership: @membership
    )
  end
end
