///
//  Generated code. Do not modify.
//  source: guest.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use idRequestDescriptor instead')
const idRequest$json = const {
  '1': 'idRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `idRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idRequestDescriptor =
    $convert.base64Decode('Cg5HdWVzdElkUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use guestRequestDescriptor instead')
const GuestRequest$json = const {
  '1': 'GuestRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
  ],
  '8': const [
    const {'1': '_id'},
  ],
};

/// Descriptor for `GuestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List guestRequestDescriptor = $convert.base64Decode(
    'CgxHdWVzdFJlcXVlc3QSEwoCaWQYASABKAlIAFICaWSIAQESEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVwaG9uZRgDIAEoCVIFcGhvbmUSFAoFZW1haWwYBCABKAlSBWVtYWlsQgUKA19pZA==');
@$core.Deprecated('Use guestResponseDescriptor instead')
const GuestResponse$json = const {
  '1': 'GuestResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `GuestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List guestResponseDescriptor = $convert.base64Decode(
    'Cg1HdWVzdFJlc3BvbnNlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXBob25lGAMgASgJUgVwaG9uZRIUCgVlbWFpbBgEIAEoCVIFZW1haWw=');
@$core.Deprecated('Use guestsResponseDescriptor instead')
const GuestsResponse$json = const {
  '1': 'GuestsResponse',
  '2': const [
    const {
      '1': 'guests',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.guest.GuestResponse',
      '10': 'guests'
    },
  ],
};

/// Descriptor for `GuestsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List guestsResponseDescriptor = $convert.base64Decode(
    'Cg5HdWVzdHNSZXNwb25zZRIsCgZndWVzdHMYASADKAsyFC5ndWVzdC5HdWVzdFJlc3BvbnNlUgZndWVzdHM=');
