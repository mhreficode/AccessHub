import { describe, expect, it } from 'vitest';
import {
  canApproveRequests,
  canReviewAccessRequest,
  canViewAuditLog,
  canRevokeKey,
} from '../utils/permissions';
import type { AccessRequest, ApiKey, User } from '../types';

const developer: User = {
  id: 'u1',
  name: 'Dev',
  email: 'd@x.dev',
  role: 'developer',
  teamId: 'team-data',
};
const owner: User = {
  id: 'u2',
  name: 'Own',
  email: 'o@x.dev',
  role: 'service_owner',
  teamId: 'team-payments',
};
const otherOwner: User = {
  id: 'u4',
  name: 'Other',
  email: 'other@x.dev',
  role: 'service_owner',
  teamId: 'team-platform',
};
const admin: User = {
  id: 'u3',
  name: 'Adm',
  email: 'a@x.dev',
  role: 'platform_admin',
  teamId: 'team-platform',
};

describe('canApproveRequests', () => {
  it('allows owners and admins', () => {
    expect(canApproveRequests(owner)).toBe(true);
    expect(canApproveRequests(admin)).toBe(true);
  });
  it('denies developers and anonymous', () => {
    expect(canApproveRequests(developer)).toBe(false);
    expect(canApproveRequests(null)).toBe(false);
  });
});

describe('canViewAuditLog', () => {
  it('denies developers', () => {
    expect(canViewAuditLog(developer)).toBe(false);
  });
});

describe('canReviewAccessRequest', () => {
  const request: AccessRequest = {
    id: 'req1',
    serviceId: 's1',
    requesterUserId: 'u1',
    reason: 'Need it',
    status: 'pending',
    createdAt: new Date().toISOString(),
    service: {
      id: 's1',
      name: 'Payments API',
      slug: 'payments-api',
      description: 'Payments',
      status: 'active',
      baseUrl: 'https://pay.test',
      docsMarkdown: '# Payments',
      ownerTeamId: 'team-payments',
    },
  };

  it('allows admins and owning team owners', () => {
    expect(canReviewAccessRequest(admin, request)).toBe(true);
    expect(canReviewAccessRequest(owner, request)).toBe(true);
  });

  it('denies non-owning owners and developers', () => {
    expect(canReviewAccessRequest(otherOwner, request)).toBe(false);
    expect(canReviewAccessRequest(developer, request)).toBe(false);
  });
});

describe('canRevokeKey', () => {
  const key: ApiKey = {
    id: 'k1',
    serviceId: 's1',
    serviceName: 'S',
    ownerTeamId: 'team-payments',
    userId: 'u1',
    label: 'L',
    maskedKey: 'ah_live_xx••••••••',
    status: 'active',
    createdAt: new Date().toISOString(),
  };

  it('allows the key holder', () => {
    expect(canRevokeKey(developer, key)).toBe(true);
  });
  it('allows admins', () => {
    expect(canRevokeKey(admin, key)).toBe(true);
  });

  it('allows only matching team owners', () => {
    expect(canRevokeKey(owner, key)).toBe(true);
    expect(canRevokeKey(otherOwner, key)).toBe(false);
  });
});
