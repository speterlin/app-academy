ActiveRecord::Base.transaction do
  # ideologies
  conservatism = Ideology.create!(
    name: 'Conservatism',
    direction: 'Right',
    goal: 'retain traditional social institutions')
  liberalism = Ideology.create!(
    name: 'Liberalism',
    direction: 'Left',
    goal: 'balance individual liberty and social justice')

  # parties
  democrats = Party.create!(
    name: 'Democratic Party',
    color: 'Blue',
    ideology_id: liberalism.id)
  republicans = Party.create!(
    name: 'Republican Party',
    color: 'Red',
    ideology_id: conservatism.id)

  # senators
  john = Senator.create!(
    fname: 'John',
    lname: 'McCain',
    state: 'AZ',
    party_id: republicans.id)
  marco = Senator.create!(
    fname: 'Marco',
    lname: 'Rubio',
    state: 'FL',
    party_id: republicans.id)
  mitch = Senator.create!(
    fname: 'Mitch',
    lname: 'McConnell',
    state: 'KY',
    party_id: republicans.id)
  barbara = Senator.create!(
    fname: 'Barbara',
    lname: 'Boxer',
    state: 'CA',
    party_id: democrats.id)
  dianne = Senator.create!(
    fname: 'Dianne',
    lname: 'Feinstein',
    state: 'CA',
    party_id: democrats.id)
  elizabeth = Senator.create!(
    fname: 'Elizabeth',
    lname: 'Warren',
    state: 'MA',
    party_id: democrats.id)
  harry = Senator.create!(
    fname: 'Harry',
    lname: 'Reid',
    state: 'NV',
    party_id: democrats.id)

  # add party leaders to parties
  republicans.update!(party_leader_id: mitch.id)
  democrats.update!(party_leader_id: harry.id)

  # committees
  finance = Committee.create!(
    chairperson_id: elizabeth.id,
    name: 'Finance',
    mandate: 'attend to taxation, debt, and other financial matters')
  foreign_relations = Committee.create!(
    chairperson_id: marco.id,
    name: 'Foreign Relations',
    mandate: 'lead foreign-policy legislation and debate')

  # memberships
  CommitteeMembership.create!(
    committee_id: finance.id, senator_id: barbara.id)
  CommitteeMembership.create!(
    committee_id: finance.id, senator_id: dianne.id)
  CommitteeMembership.create!(
    committee_id: finance.id, senator_id: elizabeth.id)
  CommitteeMembership.create!(
    committee_id: finance.id, senator_id: john.id)

  CommitteeMembership.create!(
    committee_id: foreign_relations.id, senator_id: harry.id)
  CommitteeMembership.create!(
    committee_id: foreign_relations.id, senator_id: john.id)
  CommitteeMembership.create!(
    committee_id: foreign_relations.id, senator_id: marco.id)

  # desks
  Desk.create!(model: 'IKEA Office (Oak)', owner_id: john.id)
  Desk.create!(model: 'Mainstays L-Shaped (Maple)', owner_id: elizabeth.id)

  # bills
  bag_ban = Bill.create!(title: 'Ban plastic bags.', author_id: dianne.id)

  BillEndorsement.create!(bill_id: bag_ban.id, senator_id: barbara.id)
  BillEndorsement.create!(bill_id: bag_ban.id, senator_id: harry.id)
  BillEndorsement.create!(bill_id: bag_ban.id, senator_id: mitch.id)
end
