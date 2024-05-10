#!/usr/bin/env python3
# This script was created by Johannes Erdfelt, all attribution goes to him.
# I'm saving this for my purposes.

"""
This script gets an authorization token from Redfish
"""

import os
import pprint
import sys

import httpx


username = 'ADMIN'
password = 'password'
bmcip = '10.8.x.x'

cachefile = '.redfish.token'


def update_token():
    print('Obtaining token')
    body = {
        'UserName': username,
        'Password': password,
    }
    r = httpx.post(f'https://{bmcip}/redfish/v1/SessionService/Sessions', json=body, verify=False)
    if r.status_code != 201:
        print(r.status_code)
        pprint.pprint(r.headers)
        pprint.pprint(r.json())

    token = r.headers['X-Auth-Token']
    with open(cachefile + '.tmp', 'w') as f:
        f.write(token)

    os.rename(cachefile + '.tmp', cachefile)

    return token


if not os.path.exists(cachefile):
    token = update_token()
else:
    token = open(cachefile).read().strip()

headers = {'X-Auth-Token': token}
r = httpx.get(f'https://{bmcip}/redfish/v1/' + sys.argv[1], headers=headers, verify=False)
if r.status_code == 401:
    token = update_token()
    headers = {'X-Auth-Token': token}
    r = httpx.get(f'https://{bmcip}/redfish/v1/' + sys.argv[1], headers=headers, verify=False)

if r.status_code != 200:
    print(r.status_code)

pprint.pprint(r.json())
